import pandas as pd
from pathlib import Path, PurePath

star_dir = Path(__file__).parent / "output" / "results" / "genecounts"

def combine_star_counts(directory):
    data = pd.DataFrame()
    files_to_process = []
    for dirpath, dirnames, filenames in Path.walk(directory):
        for file in filenames:
            if file.endswith("_ReadsPerGene.out.tab"):
                files_to_process.append(Path(file))
    files_to_process.sort()
    for file in files_to_process: 
        print(f"processing {file}")
        basename = PurePath(file).name.split("_")[0]
        raw_data = pd.read_csv(file, sep="\t")
        colnames = raw_data.columns.tolist()
        colnames[0] = "gene_id"
        colnames[1] = "unstranded"
        colnames[2] = "forward"
        colnames[3] = "reverse"
        raw_data.columns = colnames
        raw_data = raw_data[["gene_id", "reverse"]].iloc[4:]
        if data.empty:
            data = pd.concat([data, raw_data[["gene_id", "reverse"]]], axis=1)
            data.columns=['gene_id', basename]
        else:
            raw_data.columns = ['gene_id', basename]
            data = pd.merge(left = data, right = raw_data, how='left', on="gene_id")
    return data

data = combine_star_counts(star_dir)
data.to_csv('deseq2_input.csv')
