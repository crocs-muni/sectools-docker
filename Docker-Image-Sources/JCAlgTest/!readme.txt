How to obtain list of supported algorithms by your card:
1. Upload AlgTest_v1.8.0_jc305.cap to target card. If upload fails (your card doesn't support JavaCard API version 3.0.5), try to upload AlgTest_v1.8.0_jc304.cap. If upload fails, try to upload AlgTest_v1.8.0_jc222.cap. (In rare case when your card doesn't even support JavaCard API version 2.2.2, please use older version AlgTest_v1.7.1). Use 'java -jar gp.jar -install AlgTest_v1.8.0_jc305.cap' for upload (gp tool available at https://github.com/martinpaljak/GlobalPlatformPro)
2. Run 'java -jar AlgTestJClient.jar --help' to get help on on-interactive analysis
3. Run 'java -jar AlgTestJClient.jar' for interactive analysis
4. Select option 1 -> SUPPORTED ALGORITHMS
5. Fill identification (name) of your card (e.g., NXP JCOP3 J3H145g P60)
6. Wait for the test to finish (2-20 min)
7. Inspect the resulting CSV file
8. Consider sending the results (*.csv, *.log) to us at jcalgtest.org (petr@svenda.com), contribute to community-created database and compare the results with others

