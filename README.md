# checksum

维护当前目录下非隐藏文件的哈希值，用于文件完整性校验。默认算法为 MD5，[可以自行修改为 SHA](https://www.commandlinux.com/man-page/man1/shasum.1.html)。

谢谢 ChatGPT 写的这段 Bash。

## 使用方法

1. 复制到对应目录
2. `chmod +x checksum.sh`
3. `./checksum.sh`