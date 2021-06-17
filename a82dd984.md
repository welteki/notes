---
date: 2021-02-06T14:31
---

# ED25519 SSH keys

The book [Practical Cryptography With Go](https://leanpub.com/gocrypto/read#leanpub-auto-chapter-5-digital-signatures) suggest that [ED25519](https://ed25519.cr.yp.to/) keys are more secure and performant than RSA keys. As OpenSSH 6.5 introduced ED25519 SSH keys in 2014, they should be available on any current operating system.

**Generate key**

```
ssh-keygen -t ed25519 -C "<comment>"
```
