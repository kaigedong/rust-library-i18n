# 在终端中执行

# 克隆 Rust 官方仓库
git clone https://github.com/rust-lang/rust.git rust

# NOTE: 后续操作将在这个目录下完成
cd rust

# 切换版本号
# 注意：这里的版本号应该与要构建的中文文档的版本号保持一致
# 特别注意：下面这一行不能直接拷贝，版本号 `1.55.0` 一定要记得改
git checkout 1.60.0

# 删除 `rust/library` 目录
rm -rf ./library

# 克隆子仓库
git clone https://github.com/rust-lang/rust-installer.git src/tools/rust-installer
git clone https://github.com/rust-lang/cargo.git src/tools/cargo
git clone https://github.com/rust-lang/rls.git src/tools/rls
git clone https://github.com/rust-lang/miri.git src/tools/miri
git clone https://github.com/rust-lang/stdarch.git library/stdarch
git clone https://github.com/rust-lang/backtrace-rs.git library/backtrace
git clone https://github.com/rust-lang/libbacktrace library/backtrace/crates/backtrace-sys/src/libbacktrace

# 替换中文文档
# 文档下载地址：https://github.com/wtklbm/rust-library-i18n/tree/main/dist
# 将中文文档复制到 `rust/library` 目录下，已经存在的，直接选择替换

wget https://raw.githubusercontent.com/wtklbm/rust-library-i18n/main/dist/v1.60.0.zip
unzip v1.60.0.zip -d library1
mv library1/library/* library/

git config --global user.email "dongkaige@gmail.com"
git config --global user.name "kaigedong"

# 本地提交一次
git add -A
git commit -m none

# Linux/macOS Bash
echo -e "changelog-seen = 2\n[llvm]\nninja = false" >>config.toml

# Windows PowerShell
# Write-Output "changelog-seen = 2`n[llvm]`nninja = false" >> config.toml

# 构建 HTML 离线静态文档
# 关于为什么执行下面的命令能构建文档，请跳转到 Rust 官方仓库
# 有关任何关于该命令的问题，也请到相关仓库进行提问
python x.py doc library/std --stage 2

# 构建的结果将自动保存在 `rust/build/x86_64-pc-windows-msvc/doc` 目录下
# 构建完成后，请通过浏览器打开 `rust/build/x86_64-pc-windows-msvc/doc/std/index.html` 文件

cd ..
