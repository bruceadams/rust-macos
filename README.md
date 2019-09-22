# Rust macOS

Cross compile Rust programs in a Docker container.

```bash
docker run --rm --user $(id -u):$(id -g) --volume "$PWD:/build" bruceadams/rust-macos
```

This is takes, and probably misinterprets, the instructions in
https://wapl.es/rust/2019/02/17/rust-cross-compile-linux-to-macos.html
to setup a Docker image with the Linux goodies needed to cross compile to macOS.
