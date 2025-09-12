return {
  'kiyoon/jupynium.nvim',
  build = 'uv pip install . --python=$HOME/src/fiftyone-examples/.venv/bin/python',
  opts = {
    python_host = { 'uv', 'run', '--directory', '/Users/adam/src/fiftyone-examples/', 'python' },
    jupyter_command = { 'uv', 'run', '--directory', '/Users/adam/src/fiftyone-examples/', 'jupyter' },
    use_default_keybindings = false,
  },
}
