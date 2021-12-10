from sys import argv

if(len(argv)!=3):
    print("Arguments Error!\nremove_masked.py [.fa file]  [persentage(Ex. 0.5)]")
    exit(1)

if __name__ == "__main__":
    with open(argv[1],"r") as fa:
        data = [x.replace("\n","") for x in fa.readlines()]
        ids = [id for id in data if id.startswith(">")]
        seqs = [seq for seq in data if not seq.startswith(">")]

    for i in range(len(ids)):
        tmp = float(seqs[i].count("N")) / (len(seqs[i])) 
        if  tmp <= float(argv[2]):
            print(ids[i])
            print(seqs[i])
