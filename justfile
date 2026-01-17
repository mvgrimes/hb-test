APP      := "hb-test"
VERSION  := `perl -nE'm{version\s*=\s*"(\d+\.\d+.\d+)"} && print $1' ./main.go`

build:
  echo "Building verions {{VERSION}} of {{APP}}"
  go build -o {{APP}} ./main.go

lint:
  go vet ./... || true
  golangci-lint run ./... || true
  govulncheck ./...

release:
  git diff --exit-code
  git tag "{{VERSION}}"
  goreleaser release --clean
