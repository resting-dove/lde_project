import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
import json
import os
import re

relabel = {
    "bond_sgemm_vec256": "sTile + vec256",
"bond_sgemm": "sTile",
"bond_first_vec256": "Tile + vec256",
"bond_half_vec256": "1/2 Tile + vec256",
"auto_tile":"auto Tile",
"auto_vec_256":"auto Tile + vec256",
"auto_vec_256_server":"Server: auto Tile + vec256",
"naive":"naive",
"bond_first_unroll4": "Tile + unroll",
"bond_first_unroll4_vec256": "Tile + unroll + vec256",
"bond_tile": "Tile 2",
"bond_half": "1/2 Tile",
"bond_first": "Tile",
"bond_first_vec64": "Tile + vec64",
"vec32":"vec32",
"vec64":"vec64",
"vec128":"vec128",
"vec256":"vec256",
"bond_tile_vec256":"Tile 2 + vec256",
"bond_tile_vec256_server":"Server: Tile 2 + vec256",
"kernel": "BLAS",
"kernel_server": "Server: BLAS",
"invert":"Inv. Loops",
"invert_vec256":"Inv. Loops + vec256",
"accumulator": "Accumulator",
"bond_sgemm": "Tile 3",
"bond_sgemm_vec_256": "Tile 3 + vec256",
"tiled": "Tile",
}

blue = (38/255, 201/255, 255/255)
red = (255/255, 46/255, 120/255)
yellow = (255/255, 255/255, 64/255)
green1 = (41/255, 255/255, 105/255)
purple = (186/255, 84/255, 255/255)
orange = (255/255, 105/255, 51/255)
black = (0, 0, 0)
# 1: Query compilation and execution times
medians = {}
for file_name in os.listdir("./scripts/outputs_machine/"):
    if "json" in file_name:
        with open(os.path.join("./scripts/outputs_machine/", file_name), "rt") as file:
            j = json.load(file)
            name = file_name.split(".")[0]
            res = j["results"][0]
            medians[name] = res["median"]

bar = plt.bar(*zip(*sorted(medians.items(), key=lambda x: x[0])))
plt.xticks(rotation='vertical')
plt.title("Median query compilation + execution Matmul 2048")
plt.ylabel("seconds")
plt.yscale("symlog")
plt.tight_layout()
plt.savefig("Figures/compilationExecution.png")
plt.close()

# 2: Query execution times.
medians = {}
for file_name in os.listdir("./scripts/outputs_machine/"):
    if ".out" in file_name:
        with open(os.path.join("./scripts/outputs_machine/", file_name), "rt") as file:
            times = []
            lines = file.readlines()
            for line in lines:
                if line[:3] == "ms:":
                    times.append(float(line[3:]) / 1000)

            name = file_name.split(".")[0]
            res = np.median(times)
            medians[name] = res

bar = plt.bar(*zip(*sorted(medians.items(), key=lambda x: x[0])))
plt.xticks(rotation='vertical')
plt.title("Median execution times Matmul 2048")
plt.ylabel("seconds")
plt.yscale("symlog")
plt.tight_layout()
plt.savefig("Figures/execution.png")
plt.close()

# Single precision
medians = {}
for file_name in os.listdir("./scripts/outputs_machine/"):
    if ".singleout" in file_name:
        with open(os.path.join("./scripts/outputs_machine/", file_name), "rt") as file:
            times = []
            lines = file.readlines()
            for line in lines:
                if line[:3] == "ms:":
                    times.append(float(line[3:]) / 1000)

            name = file_name.split(".")[0]
            res = np.median(times)
            medians[name] = res

bar = plt.bar(*zip(*sorted(medians.items(), key=lambda x: x[0])))
plt.xticks(rotation='vertical')
plt.title("Median execution times f32 Matmul 2048")
plt.ylabel("seconds")
plt.yscale("symlog")
plt.tight_layout()
plt.savefig("Figures/singleExecution.png")
plt.close()


# 3: Variable sizes
times = {}
for file_name in os.listdir("./scripts/outputs/"):
    if "sizes.out" in file_name:
        with open(os.path.join("./scripts/outputs/", file_name), "rt") as file:
            lines = file.readlines()
            current_times = {}
            current_size = None
            for line in lines:
                if line[:3] == "ms:":
                    current_times[current_size].append(float(line[3:]) / 1000)
                elif line[:3] == "sum":
                    pass
                else:
                    current_size = int(line)
                    current_times[current_size] = []

            name = file_name.split(".")[0]
            name = re.sub("_sizes", "", name)
            times[name] = {k: np.median(v) for k,v in current_times.items()}
ax = pd.DataFrame(times).sort_index().plot(kind="bar", title="Various size Matmul execution times")
ax.set_xlabel("Linear Matrix size")
ax.set_ylabel("seconds")
ax.set_yscale("log")
plt.tight_layout()
plt.savefig("Figures/varSizes.png")
plt.close()

# 3b: Subset of Variable sizes
times = {}
for file_name in ["invert_vec256_sizes.out", "kernel_sizes.out", "bond_sgemm_vec256_sizes.out", "bond_tile_sizes.out"]:
    if "sizes.out" in file_name:
        with open(os.path.join("./scripts/outputs/", file_name), "rt") as file:
            lines = file.readlines()
            current_times = {}
            current_size = None
            for line in lines:
                if line[:3] == "ms:":
                    current_times[current_size].append(float(line[3:]) / 1000)
                elif line[:3] == "sum":
                    pass
                else:
                    current_size = int(line)
                    current_times[current_size] = []

            name = file_name.split(".")[0]
            name = re.sub("_sizes", "", name)
            times[relabel[name]] = {k: np.median(v) for k,v in current_times.items()}
df = pd.DataFrame(times)
df.reindex(sorted(df.columns), axis=1)
df.drop(2047, axis=0, inplace=True)
ax = df.sort_index().plot(marker="x", linewidth=3,color=[purple, red, blue, orange])
#plt.title("Scaling of Matrix Multiplication")
ax.set_xlabel("Linear Matrix size")
ax.set_ylabel("seconds")
ax.set_yscale("log")
ax.set_xscale("log")
plt.tight_layout()
plt.savefig("Figures/varSizesSubset.png")
plt.close()

#4 Integer
medians = {}
for file_name in os.listdir("./scripts/outputs_machine/"):
    if ".intout" in file_name:
        with open(os.path.join("./scripts/outputs_machine/", file_name), "rt") as file:
            times = []
            lines = file.readlines()
            for line in lines:
                if line[:3] == "ms:":
                    times.append(float(line[3:]) / 1000)

            name = file_name.split(".")[0]
            res = np.median(times)
            medians[relabel[name]] = res

bar = plt.bar(*zip(*sorted(medians.items(), key=lambda x: x[0])), color=blue)
plt.xticks(rotation='vertical')
plt.title("Median execution times ui64 Matmul 2048")
plt.ylabel("seconds")
plt.yscale("symlog")
plt.tight_layout()
plt.savefig("Figures/intExecution.png")
plt.close()

# 5: Matrix vector products
times = {}
for file_name in os.listdir("./scripts/outputs/"):
    if ".matvec" in file_name:
        with open(os.path.join("./scripts/outputs/", file_name), "rt") as file:
            lines = file.readlines()
            current_times = {}
            current_size = None
            for line in lines:
                if line[:3] == "ms:":
                    current_times[current_size].append(float(line[3:]) / 1000)
                elif line[:3] == "sum":
                    pass
                else:
                    current_size = int(line)
                    current_times[current_size] = []

            name = file_name.split(".")[0]
            times[name] = {k: np.median(v) for k,v in current_times.items()}
ax = pd.DataFrame(times).sort_index().plot(kind="bar", title="MatVec execution times")
ax.set_xlabel("Vector size")
ax.set_ylabel("seconds")
ax.set_yscale("log")
plt.tight_layout()
plt.savefig("Figures/matVec.png")
plt.close()

# 5b: Subset of Matrix vector products
times = {}
for file_name in ["kernel_sizes.matvec", "bond_first_vec64_sizes.matvec", "naive_sizes.matvec", "invert_sizes.matvec"]:
    if ".matvec" in file_name:
        with open(os.path.join("./scripts/outputs/", file_name), "rt") as file:
            lines = file.readlines()
            current_times = {}
            current_size = None
            for line in lines:
                if line[:3] == "ms:":
                    current_times[current_size].append(float(line[3:]) / 1000)
                elif line[:3] == "sum":
                    pass
                else:
                    current_size = int(line)
                    current_times[current_size] = []

            name = file_name.split(".")[0]
            name = re.sub("_sizes", "", name)
            times[relabel[name]] = {k: np.median(v) for k,v in current_times.items()}
ax = pd.DataFrame(times).sort_index().drop(2047, axis=0).plot(linewidth=3, marker="x", color=[purple, red, blue, orange])
ax.set_xlabel("Vector size")
ax.set_ylabel("seconds")
ax.set_yscale("log")
ax.set_xscale("log")
plt.tight_layout()
plt.savefig("Figures/matVecSubset.png")
plt.close()

#6: Potential of packing using DataCopyGenerate
times = {}
for file_name in ["kernel.8192out", "tiled.8192out"]:
    with open(os.path.join("./scripts/outputs/", file_name), "rt") as file:
        lines = file.readlines()
        current_times = {8192: []}
        current_size = 8192
        for line in lines:
            if line[:3] == "ms:":
                current_times[current_size].append(float(line[3:]) / 1000)
            elif line[:3] == "sum":
                pass
        name = file_name.split(".")[0]
        times[relabel[name]] = {k: np.median(v) for k,v in current_times.items()}
with open(os.path.join("./scripts/outputs/", "packed.8192out"), "rt") as file:
    lines = file.readlines()
    for line in lines:
        if line[:4] == "real":
            minutes = int(re.sub("m", "", re.findall("[0-9]*m", line)[0]))
            seconds = float(re.sub(",", ".", re.sub("s", "", re.findall("[0-9,]*s", line)[0])))
            times["Tile + Packing"] = {8192: minutes * 60 + seconds}
            break
with open(os.path.join("./scripts/outputs/", "vec_packed.8192out"), "rt") as file:
    lines = file.readlines()
    for line in lines:
        if line[:4] == "real":
            minutes = int(re.sub("m", "", re.findall("[0-9]*m", line)[0]))
            seconds = float(re.sub(",", ".", re.sub("s", "", re.findall("[0-9,]*s", line)[0])))
            times["Tile + vec256 + Packing"] = {8192: minutes * 60 + seconds}
            break
df = pd.DataFrame(times).sort_index()
ax = df.iloc[0].sort_values(ascending=False).plot(kind="bar", color=blue)
#ax.set_xlabel("Linear Matrix size")
ax.set_ylabel("seconds")
ax.set_yscale("log")
plt.tight_layout()
plt.savefig("Figures/packing.png")
plt.close()

# 7: Server Run
times = {}
for file_name in os.listdir("./scripts/outputs/"):
    if "server.out" in file_name:
        with open(os.path.join("./scripts/outputs/", file_name), "rt") as file:
            lines = file.readlines()
            current_times = {}
            current_size = None
            for line in lines:
                if line[:3] == "ms:":
                    current_times[current_size].append(float(line[3:]) / 1000)
                elif line[:3] == "sum":
                    pass
                else:
                    current_size = int(line)
                    current_times[current_size] = []

            name = file_name.split(".")[0]
            times[name] = {k: np.median(v) for k,v in current_times.items()}
ax = pd.DataFrame(times).sort_index().plot(kind="bar", title="Various size Matmul execution times on DAMS Server")
ax.set_xlabel("Linear Matrix size")
ax.set_ylabel("seconds")
ax.set_yscale("log")
plt.tight_layout()
plt.savefig("Figures/server.png")
plt.close()

# 8: Server Run vs Local
times = {}
for file_name in ["bond_tile_vec256_server.out", "kernel_server.out"]:
    with open(os.path.join("./scripts/outputs/", file_name), "rt") as file:
        lines = file.readlines()
        current_times = {}
        current_size = None
        for line in lines:
            if line[:3] == "ms:":
                current_times[current_size].append(float(line[3:]) / 1000)
            elif line[:3] == "sum":
                pass
            else:
                current_size = int(line)
                current_times[current_size] = []

        name = file_name.split(".")[0]
        times[relabel[name]] = {k: np.median(v) for k,v in current_times.items()}
    file_name = re.sub("server", "sizes", file_name)
    with open(os.path.join("./scripts/outputs/", file_name), "rt") as file:
        lines = file.readlines()
        current_times = {}
        current_size = None
        for line in lines:
            if line[:3] == "ms:":
                if current_size >= 2048:
                    current_times[current_size].append(float(line[3:]) / 1000)
            elif line[:3] == "sum":
                pass
            else:
                current_size = int(line)
                if current_size >= 2048:
                    current_times[current_size] = []

        name = file_name.split(".")[0]
        name = re.sub("_sizes", "", name)
        times[relabel[name]] = {k: np.median(v) for k,v in current_times.items()}
df = pd.DataFrame(times).sort_index()
ax = df.plot(kind="bar", title="Matmul execution times on DAMS Server vs laptop", color=[purple, red, blue, orange])
ax.set_xlabel("Linear Matrix size")
ax.set_ylabel("seconds")
ax.set_yscale("log")
plt.tight_layout()
plt.savefig("Figures/serverVsLocal.png")
plt.close()

# 9: Effect of Tiling
medians = {}
for file_name in ["naive.out", "invert.out", "auto_tile.out", "bond_first.out", "bond_half.out", "bond_sgemm.out", "bond_tile.out", "kernel.out"]:
    if ".out" in file_name:
        with open(os.path.join("./scripts/outputs_machine/", file_name), "rt") as file:
            times = []
            lines = file.readlines()
            for line in lines:
                if line[:3] == "ms:":
                    times.append(float(line[3:]) / 1000)

            name = file_name.split(".")[0]
            res = np.median(times)
            medians[relabel[name]] = res

bar = plt.bar(*zip(*sorted(medians.items(), key=lambda x: x[1], reverse=True)), color=blue)
plt.xticks(rotation='vertical')
#plt.title("Effect of Tiling strategies on 2048x2048 Matrix multiplication")
plt.ylabel("seconds")
plt.yscale("symlog")
plt.ylim((0.3, 68))
plt.tight_layout()
plt.savefig("Figures/tilingStrats.png")
plt.close()

# 10: Effect of Vectorization
medians = {}
for file_name in ["naive.out", "vec32.out", "vec64.out", "vec128.out", "vec256.out", "kernel.out"]:
    if ".out" in file_name:
        with open(os.path.join("./scripts/outputs_machine/", file_name), "rt") as file:
            times = []
            lines = file.readlines()
            for line in lines:
                if line[:3] == "ms:":
                    times.append(float(line[3:]) / 1000)

            name = file_name.split(".")[0]
            res = np.median(times)
            medians[relabel[name]] = res

bar = plt.bar(*zip(*sorted(medians.items(), key=lambda x: x[1], reverse=True)), color=blue)
plt.xticks(rotation='vertical')
#plt.title("Effect of Vectorization on 2048x2048 Matrix multiplication")
plt.ylabel("seconds")
plt.yscale("symlog")
plt.ylim((0.3, 68))
plt.tight_layout()
plt.savefig("Figures/vectorization.png")
plt.close()

# 11: Effect of Vectorization + Tiling
medians = {}
for file_name in ["naive.out", "bond_first.out", "bond_first_vec256.out", "invert_vec256.out", "kernel.out"]:
    if ".out" in file_name:
        with open(os.path.join("./scripts/outputs_machine/", file_name), "rt") as file:
            times = []
            lines = file.readlines()
            for line in lines:
                if line[:3] == "ms:":
                    times.append(float(line[3:]) / 1000)

            name = file_name.split(".")[0]
            res = np.median(times)
            medians[relabel[name]] = res

bar = plt.bar(*zip(*sorted(medians.items(), key=lambda x: x[1], reverse=True)), color=blue)
plt.xticks(rotation='vertical')
#plt.title("Combined Vectorization and Tiling of 2048x2048 Matrix multiplication")
plt.ylabel("seconds")
plt.yscale("symlog")
plt.ylim((0.3, 68))
plt.tight_layout()
plt.savefig("Figures/combinedVecTiling.png")
plt.close()

# 12: Double vs Single execution
medians1 = {}
medians2 = {}
for file_name in ["kernel", "invert_vec256", "bond_sgemm_vec256"]:
    with open(os.path.join("./scripts/outputs_machine/", file_name + ".json"), "rt") as file:
        j = json.load(file)
        name = file_name.split(".")[0]
        res = j["results"][0]
        medians1[relabel[name]] = res["median"]
    with open(os.path.join("./scripts/outputs_machine/", file_name + ".singleout"), "rt") as file:
        times = []
        lines = file.readlines()
        for line in lines:
            if line[:3] == "ms:":
                times.append(float(line[3:]) / 1000)

        name = file_name.split(".")[0]
        res = np.median(times)
        medians2[relabel[name]] = res
bar = plt.bar(*zip(*sorted(medians1.items(), key=lambda x: x[0])), color=blue)
x = medians1.keys()
y1 = medians1.values()
y2 = medians2.values()
N = len(x)
fig, ax = plt.subplots()
ind = np.arange(N)  
width = 0.35        
p1 = ax.bar(ind, y1, width, color=blue)
p2 = ax.bar(ind + width, y2, width, color=red) 
ax.set_xticks(ind + width / 2)
ax.set_xticklabels(x)
ax.legend((p1[0], p2[0]), ('f64', 'f32'))
plt.xticks(rotation='vertical')
#plt.title("2048x2048 Matrix Multiplication")
plt.ylabel("seconds")
plt.yscale("symlog")
plt.tight_layout()
plt.savefig("Figures/singleVsDouble.png")
plt.close()