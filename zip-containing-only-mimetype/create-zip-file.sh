#!/bin/bash
set -euo pipefail

rm -f mimetype.zip
zip -0 --junk-paths mimetype.zip ../template/mimetype
