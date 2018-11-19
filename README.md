# Car-parking    
  
# Install  
  
1. You must instlal docker and docker-compose    
2. Add self to docker group    
  ``` sudo usermod -aG docker $(whoami) ```    
3. clone project    
4. cd in project folder    
5. start containers  
  ``` ./serverUp.sh start```    
6. create database and data  
  ``` ./serverUp.sh migrate ```  
7. localhost:3000 in your browser  
8. Login:  
  
  login: owner  
  password: ownerr  
  
  login: operator  
  password: operator  
  
9. For more information  
  ``` ./serverUp.sh help ```  
 or here:  
 ![help](https://cdn1.savepice.ru/uploads/2018/11/4/465c63ff253bf23e7cee17f01bd76fa4-full.png)  



Project planing  (in progress) -> [Google docs](https://docs.google.com/document/d/1Y7SWlhunThO1LW4LisWeDIUvpCKcne2dgePW_D79j0o/edit?usp=sharing)  
Greate big board -> [Realtimeboard](https://realtimeboard.com/app/board/o9J_kykEGi8=/)  
Cloud for other files -> [Mail.ru cloud](https://cloud.mail.ru/public/32Du/Xgp23HFsk)