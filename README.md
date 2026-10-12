# Play Quaternion Fractal

- Demo https://r.tiye.me/Triadica/play-quaternion-fractal/

based on previous work on https://github.com/Quatrefoil-GL/play-ruled-surface .

### Workflow

https://github.com/Triadica/triadica-workflow

Use Calcit 0.29.0, Node.js 24 and Yarn 4.18.0. `calcit.cirru` is the source
Snapshot; `deps.cirru` pins the formal Calcit module releases.

```sh
corepack enable
caps --strict --ci
yarn install --immutable
caps verify --toolchain
calcit --check-only --all-defs --strict-types
calcit js
yarn vite
```

Production frontend assets use `https://cos-sh.tiye.me/Triadica/play-quaternion-fractal/`.
The existing rsync page directory remains `/web-assets/repo/Triadica/play-quaternion-fractal/`.
Actions requires `COS_BUCKET`, `COS_SECRET_ID`, `COS_SECRET_KEY` and
`rsync_private_key` for production deployment. The COS action verifies uploaded
files through the public CDN URL; PRs only check and build, without deploying.
Generated `js-out/` and `dist/` stay out of Git.

### License

MIT
