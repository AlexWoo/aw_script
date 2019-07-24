## build janus

    docker build -t alexwoo/janus ./

## run janus

	docker run --rm -p 8188:8188 alexwoo/janus

## 安装说明
由于janus安装,目前开启janus-pp-rec, 该工具依赖ffmpeg的第三方库,因此安装janus前,请优先安装ffmpeg。
安装前，请确认环境变量配置成功：
	PKG_CONFIG_PATH=/usr/lib64/pkgconfig:/usr/lib/pkgconfig:/root/ffmpeg/ffmpeg_build/lib/pkgconfig
