# Play Quaternion Fractal

- Demo https://r.tiye.me/Triadica/play-quaternion-fractal/

based on previous work on https://github.com/Quatrefoil-GL/play-ruled-surface .

### Workflow

https://github.com/Triadica/triadica-workflow

使用者影响：同步正式 Calcit/procs 0.29.3 和 Touch Control 0.0.30、Space 0.0.43、Respo 0.16.120、Quaternion 0.2.13、JS-FFI 0.2.3。项目版本保持 0.0.1，不额外发模块 release；原分形算法、初始参数与部署路径保留，仅将状态初始化改为当前命名 Struct 构造写法。strict Caps 需配套安装这套正式图，不与旧版本混装。

相对旧 Space 0.0.40，此升级继承已发布 0.0.42 的下一帧绘制/帧前请求合并语义：paint-canvas! 返回 Unit，不再保证调用栈内同步绘制完成。默认 glow 保留，项目本身不重新实现帧边界。

Use Calcit 0.29.3, Node.js 24 and Yarn 4.18.0. `calcit.cirru` is the source
Snapshot; `deps.cirru` pins the formal Calcit module releases.

```sh
corepack enable
caps --strict --ci
yarn install --immutable
caps verify --toolchain
calcit --check-only --all-defs
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
