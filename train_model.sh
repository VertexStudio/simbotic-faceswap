docker exec -ti simbotic-faceswap bash -c "export QT_X11_NO_MITSHM=1; python faceswap.py train -A $1 -B $2 -m $3 -p"