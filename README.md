# Azure CycleCloud template for MSC Software Cradle SCRYU/Tetra, scFLOW, STREAM

## Prerequisites

1. Prepare for your SCRYU/Tetra, scFLOW, STREAM bilnary.
1. Prepare for Intel MPI binary for SCRYU/Tetra v11, v13
1. pogo update (Azure CycleCloud upload configuration)
1. Install CycleCloud CLI

## How to install 

1. tar zxvf cyclecloud-Cradle<version>.tar.gz
1. cd cyclecloud-Cradle<version>
1. pug OSS PBS Pro files on <template>/blob directory.
1. Rewrite "Files" attribute for your binariy in "project.ini" file. 
1. run "cyclecloud project upload azure-storage" for uploading template to CycleCloud
1. "cyclecloud import_template -f templates/pbs_extended_nfs_cradle.txt" for register this template to your CycleCloud

## How to run MSC Software Cradle SCRYU/Tetra, scFLOW, STREAM

1. Create Execute Node manually
1. Check Node IP Address
1. Create hosts file for your nodes
1. qsub ~/run.sh

## Known Issues
1. This tempate support only single administrator. So you have to use same user between superuser(initial Azure CycleCloud User) and deployment user of this template

# Azure CycleCloud用テンプレート:SCRYU/Tetra, scFLOW, STREAM (NFS/PBSPro)

[Azure CycleCloud](https://docs.microsoft.com/en-us/azure/cyclecloud/) はMicrosoft Azure上で簡単にCAE/HPC/Deep Learning用のクラスタ環境を構築できるソリューションです。

![Azure CycleCloudの構築・テンプレート構成](https://raw.githubusercontent.com/hirtanak/osspbsdefault/master/AzureCycleCloud-OSSPBSDefault.png "Azure CycleCloudの構築・テンプレート構成")

Azure CyceCloudのインストールに関しては、[こちら](https://docs.microsoft.com/en-us/azure/cyclecloud/quickstart-install-cyclecloud) のドキュメントを参照してください。

本テンプレートは、SCRYU/Tetra, scFLOW, STREAM用のテンプレートになっています。

## 確認バージョン

 - SCRYU/Tetra v11, v13
 - scFLOW 2020
 - STREAM 2020

## 構成、特徴

1. OSS PBS ProジョブスケジューラをMasterノードにインストール
1. H16r, H16r_Promo, HC44rs, HB60rs, HB120rs_v2を想定したテンプレート、イメージ
	 - OpenLogic CentOS 7.6 HPC を利用 
1. Masterノードに512GB * 2 のNFSストレージサーバを搭載
	 - Executeノード（計算ノード）からNFSをマウント
1. MasterノードのIPアドレスを固定設定
	 - 一旦停止後、再度起動した場合にアクセスする先のIPアドレスが変更されない

![OSS PBS Default テンプレート構成](https://raw.githubusercontent.com/hirtanak/osspbsdefault/master/OSSPBSDefaultDiagram.png "OSS PBS Default テンプレート構成")

## テンプレートインストール方法

前提条件: テンプレートを利用するためには、Azure CycleCloud CLIのインストールと設定が必要です。詳しくは、 [こちら](https://docs.microsoft.com/en-us/azure/cyclecloud/install-cyclecloud-cli) の文書からインストールと展開されたAzure CycleCloudサーバのFQDNの設定が必要です。
また、SCRYU/Tetra, scFLOW, STREAMのバイナリ準備、およびSCRYU/Tetra v11, 13に関しては、Intel MPIインストーラー l_mpi_p_5.1.3.223.tgz が必要です。

1. テンプレート本体をダウンロード
1. 展開、ディレクトリ移動
1. cyclecloudコマンドラインからテンプレートインストール 
   - tar zxvf cyclecloud-Cradle<version>.tar.gz
   - cd cyclecloud-Cradle<version>
   - cyclecloud project upload azure-storage
   - cyclecloud import_template -f templates/pbs_extended_nfs_cradle.txt
1. 削除したい場合、 cyclecloud delete_template Cradle コマンドで削除可能

***
Copyright Hiroshi Tanaka, hirtanak@gmail.com, @hirtanak All rights reserved.
Use of this source code is governed by MIT license that can be found in the LICENSE file.
