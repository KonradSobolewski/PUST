load('wykresy/lab4pidY_5.0000_65.0000_1.0000.txt')
load('wykresy/lab4pidY_5.0000_75.0000_1.2500.txt')
load('wykresy/lab4dmcY_300_0.5000.txt')

load('wykresy/lab4Yzad.txt')

E_pid1 = sum ((lab4pidY_5_0000_75_0000_1_2500 - lab4Yzad).^2)
E_pid2 = sum ((lab4pidY_5_0000_65_0000_1_0000 - lab4Yzad).^2)

E_dmc1 = sum ((lab4dmcY_300_0_5000 - lab4Yzad).^2)