# Cookbook

## Creating a new master signing key, with subkeys for each function

```bash
$ gpg --expert --full-gen-key
> [RSA (add capabilities)]
> [remove all capabilities except certify]
$ gpg --edit-key KEYID
> addkey
> (RSA encryption, expiry, passphrase)
> save
```

## Generating a revocation certificate

```bash
gpg --gen-revoke KEYID
```

## Exporting public key

```bash
gpg --armor --export KEYID
```
