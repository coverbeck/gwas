mperm_header=" CHR                               SNP         EMP1         EMP2 "

// Find differential missingness between cases and controls; also compute HWE scores
process calculate_snp_skew_status {
  memory plink_mem_req
  cpus max_plink_cores

  input:
    path(plinks)

  output:
    path("${base}.missing"), emit: clean_diff_miss_plot_ch1
    path(mperm), emit: clean_diff_miss_ch2
    path("${base}.hwe"), emit: hwe_scores_ch
  script:
   def base  = plinks[0].baseName
   def out   = base.replace(".","_")
   def mperm = "${base}.missing.mperm"
   def phe   = plinks[3]

   """
    cp $phe cc.phe
    plink --threads ${max_plink_cores} --autosome --bfile $base $sexinfo $diffpheno --test-missing mperm=10000 --hardy --out $out
    if ! [ -e $mperm ]; then
       echo "$mperm_header" > $mperm
    fi
   """
}
