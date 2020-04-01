import sass
import os
import strutils

const
  STATIC_PATH = "public"
  STATIC_SRC = STATIC_PATH / "src"
  THIRD_PARTY = STATIC_SRC / "third_party"

echo "Removing old compiled dir"
os.removeDir(STATIC_PATH / "compiled")
discard os.existsOrCreateDir(STATIC_PATH / "compiled")

echo "Building sass"
for file in walkFiles(STATIC_SRC / "*.sass"):
  echo "Compiling " & file
  let (dir, filename, extension) = splitFile(file)
  if filename[0] != '_':
    compileFile(file, outputPath=STATIC_PATH / "compiled" / filename & ".css")

echo "Completed successfully"
