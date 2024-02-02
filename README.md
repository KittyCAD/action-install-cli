### Install Zoo CLI

Use the Zoo CLI in your Github workflows.

Example usage:
```yml
name: Install Zoo cli and convert demo
on:
  pull_request:
jobs:
  convert-with-powershell:
    runs-on: windows-latest
    steps:
      - uses: actions/checkout@v3
      - uses: Zoo/action-install-cli@v0.2.16
      - name: convert
        run: zoo file convert --output-format=stl test-file.obj ./
        shell: powershell
        env: 
          ZOO_TOKEN: ${{ secrets.ZOO_TOKEN }}
```

Make sure you [generate your `ZOO_TOKEN`](https://zoo.io/account) and add it to your repo secrets

Be sure to look at our [other Github Actions](https://github.com/marketplace?type=actions&query=zoo+).
