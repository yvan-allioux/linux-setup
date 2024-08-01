import sys
import os
import configparser
import argparse

try:
    from openai import OpenAI
except ImportError:
    OpenAI = None

# Configuration
CONFIG_DIR = os.getenv('XDG_CONFIG_HOME', os.path.expanduser('~/.config'))
OPENAI_API_KEYS_LOCATION = os.path.join(CONFIG_DIR, 'openaiapirc')

def create_template_ini_file(api_type):
    file_path = OPENAI_API_KEYS_LOCATION
    content = '[openai]\nsecret_key=\n'  # Default configuration
    url = 'https://platform.openai.com/api-keys'

    if not os.path.isfile(file_path):
        with open(file_path, 'w') as f:
            f.write(content)

        print(f'{api_type.capitalize()} API config file created at {file_path}')
        print('Please edit it and add your API key')
        print(f'If you do not yet have an API key, you can get it from: {url}')
        sys.exit(1)

def initialize_api(api_type):
    if api_type == 'openai':
        config = configparser.ConfigParser()
        config.read(OPENAI_API_KEYS_LOCATION)
        api_config = {k: v.strip("\"'") for k, v in config["openai"].items()}
        client = OpenAI(
            api_key=api_config["secret_key"],  # This key is required but unused for local setup
            base_url=api_config.get("base_url", "http://localhost:11434/v1"),  # Set local server URL
            organization=api_config.get("organization")
        )
        api_config.setdefault("model", "phi3")  # Default model
        return client, api_config

def get_completion(api_type, client, config, full_command):
    if api_type == 'openai':
        response = client.chat.completions.create(
            model=config["model"],
            messages=[
                {
                    "role": 'system',
                    "content": "You are a zsh shell expert, please help me complete the following command, you should only output the completed command, no need to include any other explanation. Do not put completed command in a code block.",
                },
                {
                    "role": 'user',
                    "content": full_command,
                }
            ],
            temperature=float(config.get("temperature", 1.0))
        )
        return response.choices[0].message.content

def main():
    parser = argparse.ArgumentParser(description="Generate command completions using AI.")
    parser.add_argument('--api', choices=['openai'], default='openai', help="Choose the API to use (default: openai)")
    parser.add_argument('cursor_position', type=int, help="Cursor position in the input buffer")
    args = parser.parse_args()

    if args.api == 'openai' and OpenAI is None:
        print("OpenAI library is not installed. Please install it using 'pip install openai'")
        sys.exit(1)

    client, config = initialize_api(args.api)

    buffer = sys.stdin.read()
    zsh_prefix = '#!/bin/zsh\n\n'
    buffer_prefix = buffer[:args.cursor_position]
    buffer_suffix = buffer[args.cursor_position:]
    full_command = zsh_prefix + buffer_prefix + buffer_suffix

    completion = get_completion(args.api, client, config, full_command)

    if completion.startswith(zsh_prefix):
        completion = completion[len(zsh_prefix):]

    line_prefix = buffer_prefix.rsplit("\n", 1)[-1]
    for prefix in [buffer_prefix, line_prefix]:
        if completion.startswith(prefix):
            completion = completion[len(prefix):]
            break

    if buffer_suffix and completion.endswith(buffer_suffix):
        completion = completion[:-len(buffer_suffix)]

    completion = completion.strip("\n")
    if line_prefix.strip().startswith("#"):
        completion = "\n" + completion

    sys.stdout.write(completion)

if __name__ == "__main__":
    main()
