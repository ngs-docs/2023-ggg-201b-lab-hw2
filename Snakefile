rule annotate:
    input:
        "SRR2584857-assembly.fa"
    output:
        directory("SRR2584857_annot")
    shell: """                                                                
       prokka --prefix {output} {input}                                       
    """

rule assemble:
    input:
        r1 = "SRR2584857_1.fastq.gz",
        r2 = "SRR2584857_2.fastq.gz"
    output:
        dir = directory("SRR2584857_assembly"),
        assembly = "SRR2584857-assembly.fa"
    shell: """                                                                
       megahit -1 {input.r1} -2 {input.r2} -f -m 5e9 -t 4 -o {output.dir}     
       cp {output.dir}/final.contigs.fa {output.assembly}                     
    """

rule quast:
    input:
        "SRR2584857-assembly.fa"
    output:
        directory("SRR2584857_quast")
    shell: """                                                                
       quast {input} -o {output}                                              
    """
