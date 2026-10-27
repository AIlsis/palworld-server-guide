#!/bin/bash
# backup-palworld-save.sh —— 打包帕鲁存档并留时间戳
# 用法：chmod +x backup-palworld-save.sh && ./backup-palworld-save.sh
# 建议挂 crontab 每天凌晨执行：0 4 * * * /path/to/backup-palworld-save.sh

set -e

SAVE_DIR="$HOME/palworld-server/Pal/Saved"
BACKUP_DIR="$HOME/palworld-backups"
STAMP=$(date +%Y%m%d-%H%M%S)

mkdir -p "$BACKUP_DIR"

if [ ! -d "$SAVE_DIR" ]; then
  echo "[错误] 找不到存档目录：$SAVE_DIR"
  echo "如果你用了其他部署方式，请修改脚本顶部的 SAVE_DIR。"
  exit 1
fi

tar -czf "$BACKUP_DIR/palworld-$STAMP.tar.gz" -C "$SAVE_DIR" .

# 只保留最近 7 份备份，防止磁盘被塞满
ls -t "$BACKUP_DIR"/palworld-*.tar.gz | tail -n +8 | xargs -r rm --

echo "[完成] 已备份到：$BACKUP_DIR/palworld-$STAMP.tar.gz"
ls -lh "$BACKUP_DIR" | tail -n 5
