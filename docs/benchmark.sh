echo '---------------------------------------------------------------------------'
free -lh
echo '---------------------------------------------------------------------------'
sysbench --test=cpu run
echo '---------------------------------------------------------------------------'
sysbench --test=memory run
echo '---------------------------------------------------------------------------'
sysbench --test=fileio --file-test-mode=seqwr run
echo '---------------------------------------------------------------------------'

