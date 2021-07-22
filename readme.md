Assumption ( flow of the ordering process) :

    . The user can add multiple product in the cart.
    . For user there are different payment method such as cash, card etc.
    . The user can store details of different payment methods such as card_no, card_holder_name etc.
    . The customer can place order on multiple products and can apply any payment method to it.
    . The customer can choose payment method such as cash on delivery or online method.
    . There can be different discount coupons for any product also there may be direct discount given by seller or by the site itself.
    . The user can apply different product coupons on the complete order as well such as ( first time shopping , order amount exceeding ).
    . The user can give review or rating to the product basis on their personal experiance.

Design pattern : 

    . There are multiple category of product such as food , furniture etc. and for these category can have sub category of product.
    . For example : Food has category of fruites , vegetable and then  fruites can have actual product like apple , banana etc . so this hierarchy are  maintain in the design.
    . Product has different proprties such as color , size , weight , discount for that product etc and these properties can apply to all products so this many to many relationship is maintain in  design.          
    . The customer can have multiple addresses such as work add, home add. etc on the same add there can be multiple customer so this relationship also handle in design.
    . The celler has only one address but on the same address there can be multiple celler so this relationship also handle in design.
    . same product can be sold by multiple seller and one seller can sell multiple products.
    . there are different discount coupons for different product  and  the complete order.we cannot apply same discount coupons for both order and product. so in the design there is different discount coupons for product and order.
    . The relations in the assumptions mentioned above are also maintained in design.  
