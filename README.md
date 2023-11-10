### Install KittyCAD CLI

Use the KittyCAD CLI in your Github workflows.

Example usage:
```yml
name: Install KittyCAD cli and convert demo
on:
  pull_request:
jobs:
  convert-with-powershell:
    runs-on: windows-latest
    steps:
      - uses: actions/checkout@v3
      - uses: KittyCAD/action-install-cli@v0.2.12
      - name: convert
        run: kittycad file convert --output-format=stl test-file.obj ./
        shell: powershell
        env: 
          KITTYCAD_API_TOKEN: ${{ secrets.KITTYCAD_API_TOKEN }}
```

Make sure you [generate your `KITTYCAD_API_TOKEN`](https://kittycad.io/account) and add it to your repo secrets

Be sure to look at our [other Github Actions](https://github.com/marketplace?type=actions&query=kittycad+).
