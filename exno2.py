#detail collector using control statement & loops
details=[]
while True:
   
     while True:
        e_id=input("enter the employee id ")
        if len(e_id)!="":
            break
     while True:
        name=input("enter the first name\n\t" )
        if name !="":
            break
     salary=float(input("Enter youer salary : \n\t"))
     if salary <20000:
         a,b,c=0.2,0.5,0.12
     else:
         a,b,c=0.4,0.3,0.15
        
     pf=salary*a
     hra=salary*b
     da=salary*c
     gross_salary=salary+hra+da
     net_salary=gross_salary-pf
     detail=[e_id,name,salary,pf,hra,da,gross_salary,net_salary]
     details.append(detail)
     if input("do you want to break yes/no ?\n\t").upper()=="YES":
         print("\n\n\n\n")
         break
        
info=["e_id","name","salary","pf","hra","da","gross salary","net salary"]
for detail in details:
    for inf,detail in zip(info,detail):
        print(inf.center(15),":\t",detail)

    print("\n\n","----------"*5,"\n\n")

