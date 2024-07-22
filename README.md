# Update Android Version Code

This GitHub Action increments the `versionCode` in the `build.gradle` file for an Android project.

## Inputs

### `project_name`

**Required** The name of the Android project directory containing the `build.gradle` file. Default is `app`.

## Example Usage

```yaml
name: Update Version Code

on:
  push:
    branches:
      - master

jobs:
  update-version-code:
    runs-on: ubuntu-latest

    steps:
      - name: Checkout repository
        uses: actions/checkout@v2

      - name: Update version code
        uses: your-username/your-repo-name@v1
        with:
          project_name: 'app'
```
