on:
  push:
    # Sequence of patterns matched against refs/tags
    tags:
    - 'c*' # Push events to matching v*, i.e. v1.0, v20.15.10

name: Validate a release

jobs:
  sanity_check_release:
    name: Sanity check the release
    runs-on: ubuntu-latest
    steps:
      - name: Get the version
        id: get_version
        run: echo ::set-output name=VERSION::${GITHUB_REF/refs\/tags\//}
      - name: Install JQ
        run: sudo apt-get update && sudo apt install -y jq
      - name: Checkout
        uses: actions/checkout@v2
      - name: Validate the release
        #run: curl https://api.github.com/repos/${{ github.repository }}/releases/${{ steps.get_version.outputs.VERSION }} > release.json
        run: sh release-scripts/validate-release.sh