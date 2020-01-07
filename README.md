# 🚧 Currently WIP. Do not use! 🚧 
# Integration Tests - GitHub Action

An GitHub Action to execute a full Schul-Cloud integration tests

## Example usage

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
