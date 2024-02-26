import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
import json
import os
import re

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
plt.savefig("compilationExecution.png")
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
plt.savefig("execution.png")
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
plt.savefig("singleExecution.png")
plt.close()


# 3: Variable sizes
times = {}
for file_name in os.listdir("./scripts/outputs/"):
    if ".out" in file_name:
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
ax = pd.DataFrame(times).sort_index().plot(kind="bar", title="Various size Matmul execution times")
ax.set_xlabel("Linear Matrix size")
ax.set_ylabel("seconds")
ax.set_yscale("log")
plt.tight_layout()
plt.savefig("varSizes.png")
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
            medians[name] = res

bar = plt.bar(*zip(*sorted(medians.items(), key=lambda x: x[0])))
plt.xticks(rotation='vertical')
plt.title("Median execution times int32 Matmul 2048")
plt.ylabel("seconds")
plt.yscale("symlog")
plt.tight_layout()
plt.savefig("intExecution.png")
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
plt.savefig("matVec.png")
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
        times[name] = {k: np.median(v) for k,v in current_times.items()}
with open(os.path.join("./scripts/outputs/", "packed.8192out"), "rt") as file:
    lines = file.readlines()
    for line in lines:
        if line[:4] == "real":
            minutes = int(re.sub("m", "", re.findall("[0-9]*m", line)[0]))
            seconds = float(re.sub("s", "", re.findall("[0-9.]*s", line)[0]))
            times["packed"] = {8192: minutes * 60 + seconds}
            break
ax = pd.DataFrame(times).sort_index().plot(kind="bar", title="Potential effect of Packing")
ax.set_xlabel("Linear Matrix size")
ax.set_ylabel("seconds")
ax.set_yscale("log")
plt.tight_layout()
plt.savefig("packing.png")
plt.close()