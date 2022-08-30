echo "删除文件并复制！"
SOURCE_PATH="/Volumes/Elements/winda"
DEST_PATH="/Applications/World_of_Warcraft/_classic_/Interface/AddOns/winda"

echo "source -> $SOURCE_PATH"
echo "dest -> $DEST_PATH"

if [ -d $DEST_PATH ]
then
	rm -rf $DEST_PATH
	echo "$DEST_PATH 删除成功！"
else
	echo "目标路径不存在，无法删除"
fi
if [ -d $SOURCE_PATH ]
then
	cp -r $SOURCE_PATH $DEST_PATH
	echo "$SOURCE_PATH 复制成功！"
else
	echo "源路径不存在，无法复制！"
fi
