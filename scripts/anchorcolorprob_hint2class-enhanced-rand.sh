python3 -m torch.distributed.launch --nproc_per_node=4 ./main/colorizer/anchor_colorizer_ddp.py --model AnchorColorProb --dataset imagenet --batch_size 24 --data_dir /apdcephfs/share_1290939/0_public_datasets/imageNet_2012 --save_dir /apdcephfs_cq2/share_1290939/richardxia/Saved --ckpt_dir /apdcephfs/share_1290939/richardxia/Saved/checkpoints --exp_name AnchorColorProb_hint2class-enhanced-rand --dense_pos --enhanced --random_hint --scheduler cosine