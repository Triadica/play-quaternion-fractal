# Play Quaternion Fractal

- Demo https://r.tiye.me/Triadica/play-quaternion-fractal/

based on previous work on https://github.com/Quatrefoil-GL/play-ruled-surface .

### Workflow

https://github.com/Triadica/triadica-workflow

使用者影响：同步正式 Calcit/procs 0.30.1 和已发布 Touch Control 0.0.32、Space
0.0.44、Respo 0.16.124、Quaternion 0.2.16、JS-FFI 0.2.5。需要成套重新安装并完整
刷新页面，不混用旧 runtime 或 hash/alpha 依赖。项目版本保持 0.0.1，不额外发模块
release；原分形算法、初始参数、命名 Store 合同、页面 hud! 和部署路径均保留。

官方 AST 盘点覆盖6个namespace/20个定义、原测试0/examples0：旧Option/ref/watch写法
已清理，本次不为制造源码改动而重复重写算法。原 Snapshot 保持不变；CI增加完整
strict、5个公开namespace检查与旧调用/动态方法零门槛，不增加验证脚本、基线或框架。
零个附带测试不代表算法覆盖，实际页面拖点、控制按钮、层级和刷新需单独验收。

相对旧 Space 0.0.40，此升级继承已发布 0.0.42 的下一帧绘制/帧前请求合并语义：paint-canvas! 返回 Unit，不再保证调用栈内同步绘制完成。默认 glow 保留，项目本身不重新实现帧边界。

Use formal Calcit 0.30.1, Node.js 24 and Yarn 4.18.0. `calcit.cirru` is the source
Snapshot; `deps.cirru` pins the formal Calcit module releases.

```sh
corepack enable
caps --strict --ci
yarn install --immutable
caps verify --toolchain
calcit --check-only --all-defs
calcit fix --workflow strict --verify
calcit js
yarn vite
```

Production frontend assets use `https://cos-sh.tiye.me/Triadica/play-quaternion-fractal/`.
The existing rsync page directory remains `/web-assets/repo/Triadica/play-quaternion-fractal/`.
Actions requires `COS_BUCKET`, `COS_SECRET_ID`, `COS_SECRET_KEY` and
`rsync_private_key` for production deployment. The COS action verifies uploaded
files through the public CDN URL; PRs only check and build, without deploying.
PR artifacts use relative URLs for isolated runtime acceptance. Production jobs
are not cancelled midway by a newer push; original main revision guards remain.
Generated `js-out/` and `dist/` stay out of Git.

### License

MIT
