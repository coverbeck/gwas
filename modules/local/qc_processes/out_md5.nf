// Generate MD5 sums of output paths
process out_md5 {
  memory other_mem_req
  echo true

  input:
     tuple path(bed), path(bim), path(fam), path(log)

  output:
    path(out), emit: report_outmd5_ch

  script:
       def out  = "${bed.baseName}.md5"
       template "md5.py"
}
