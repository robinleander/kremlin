KreMLin
-------

[![Build Status](https://travis-ci.org/FStarLang/kremlin.svg?branch=master)](https://travis-ci.org/FStarLang/kremlin)

KreMLin is a tool that extracts an F\* program to readable C code. If the F\*
program verifies against a low-level memory model that talks about the stack and
the heap; if it is first-order; if it obeys certain restrictions (e.g.
non-recursive data types) then KreMLin will turn it into C.

The best way to learn about KreMLin is its work-in-progress
[tutorial](https://fstarlang.github.io/lowstar/html/). Pull requests and
feedback are welcome!

- [DESIGN.md](DESIGN.md) has a technical overview of the different
  transformation passes performed by KreMLin, and is slightly out of date.

This work has been formalized on paper. We state that the compilation of
such F\* programs to C preserves semantics. We start from Low\*, a subset of
F\*, and relate its semantics to [CompCert](http://compcert.inria.fr/)'s Clight.
- the [ICFP 2017 Paper] provides an overview of KreMLin as well
  as a paper formalization of our compilation toolchain

We have written 20,000 lines of low-level F\* code, implementing the [TLS
1.3](https://tlswg.github.io/tls13-spec/) record layer. As such, KreMLin is a
key component of [Project Everest](https://project-everest.github.io/).
- [HACL*], our High Assurance Crypto Library, provides numerous cryptographic
  primitives written in F\*; these primitives enjoy memory safety, functional
  correctness, and some degree of side-channel resistance -- they extract to C
  via KreMLin.

[ML Workshop Paper]: https://jonathan.protzenko.fr/papers/ml16.pdf
[HACL*]: https://github.com/mitls/hacl-star/
[ICFP 2017 Paper]: https://arxiv.org/abs/1703.00053

## Trying out KreMLin

KreMLin requires OCaml (> 4.04.0) and OPAM.

`$ opam install ppx_deriving_yojson zarith pprint menhir ulex process fix wasm visitors`

Then, make sure you have an up-to-date F\*, and that you ran `make` in the
`ulib/ml` directory of F\*. The `fstar.exe` executable should be on your PATH.

To build just run `make` from this directory.

**Note:** on OSX, KreMLin is happier if you have `greadlink` installed (`brew
install coreutils`).

If you have the right version of F* and `fstar.exe` is in your `PATH` then you
can run the KreMLin test suite by doing `make test`.

File a bug if things don't work!

### Arch Linux

KreMLin is available in the [Arch User Repository](https://aur.archlinux.org/packages/kremlin/).
You can install it with an [AUR helper](https://wiki.archlinux.org/index.php/AUR_helpers#Active) like [`yay`](https://aur.archlinux.org/packages/yay/):

```bash
sudo pacman -S opam
yes ''|opam init
yay -S z3-git kremlin --noconfirm
```

The installation may take a while (~50 minutes from scratch).

## Documentation

The `--help` flag contains a substantial amount of information.

```
$ ./krml --help
```

## License

Kremlin is released under the [Apache 2.0 license]; see `LICENSE` for more details.

[Apache 2.0 license]: https://www.apache.org/licenses/LICENSE-2.0
