{ pkgs ? import <nixpkgs> {} }:
pkgs.callPackage ./evil.nix {}
