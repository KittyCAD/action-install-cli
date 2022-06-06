### Install KittyCAD CLI

If you want to use the KittyCAD cli directly in your actions, for example:
```yml
name: "install KittyCAD cli"
on:
  pull_request:
jobs:
  my-job:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      - uses: KittyCAD/ts-actions/install-kittycad@v0.2.2
      - name: use KittyCAD cli
        run: kittycad --version # do things with cli
        env: 
          KITTYCAD_API_TOKEN: ${{ secrets.KITTYCAD_API_TOKEN }}
```
