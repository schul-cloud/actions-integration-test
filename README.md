# 🚧 DEPRECATED REPO. Do not use! 🚧

Use the following action with a simple bash script instead:
```yml
name: Test

on: [push]

jobs:
  integration:
    runs-on: ubuntu-latest
    steps:
      - name: execute tests
        run: curl "https://raw.githubusercontent.com/schul-cloud/integration-tests/develop/scripts/ci/fetch.github.sh" | bash
      - uses: actions/upload-artifact@v1
        if: always()
        with:
          name: report
          path: integration-tests/reports
```
src: https://github.com/schul-cloud/integration-tests/blob/develop/scripts/ci/fetch.github.sh


--- 

# ~Integration Tests - GitHub Action~

~An GitHub Action to execute a full Schul-Cloud integration tests~

## ~Example usage~

```yml
name: Integration Tests
on: [push]
jobs:
  integration-tests:
    runs-on: ubuntu-latest
    steps:
      - name: integration-tests
        uses: schul-cloud/actions-integration-tests@master
      # upload buils artifacts
      - uses: actions/upload-artifact@v1
        with:
          name: report
          path: reports
```
