require('code_runner').setup {
  term = {
    position = "belowright",
    size = 15,
  },
  filetype = {
    python = "time python3 $fileName",
    c = "time cd $dir && clang -lpthread -g -lm $fileName -o $fileNameWithoutExt.out  && $dir/$fileNameWithoutExt.out",
    cpp = "time cd $dir && clang++ -lpthread -g $fileName -o $fileNameWithoutExt.out  && $dir/$fileNameWithoutExt.out",
    html = "microsoft-edge $fileName",
    sh = "time bash $file",
    rust = "time cargo run",
    r = "time Rscript $fileName",
    go = "time go run $fileName"
  },
}
