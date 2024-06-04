#!/bin/bash

# -x: 実行したコマンドと引数も出力する
# -e: スクリプト内のコマンドが失敗したとき（終了ステータスが0以外）にスクリプトを直ちに終了する
# -E: '-e'オプションと組み合わせて使用し、サブシェルや関数内でエラーが発生した場合もスクリプトの実行を終了する
# -u: 未定義の変数を参照しようとしたときにエラーメッセージを表示してスクリプトを終了する
# -o pipefail: パイプラインの左辺のコマンドが失敗したときに右辺を実行せずスクリプトを終了する 
set -eEuo pipefail
shopt -s inherit_errexit # '-e'オプションをサブシェルや関数内にも適用する

script_dir_path="$(cd "$(dirname "${BASH_SOURCE[0]}")" &> /dev/null && pwd)"
script_dir_name=$(basename "$script_dir_path")

volume_name=db_data
volume_fullname=${script_dir_name}_${volume_name}

echo "リストア開始..."

docker compose stop

docker run --rm \
    --mount source=${volume_fullname},target=/volume \
    -v ${script_dir_path}:/backup \
    busybox \
    /bin/sh -c "rm -rf /volume/* && tar -xzf /backup/${volume_name}.tar.gz -C /volume"

echo "リストア完了"