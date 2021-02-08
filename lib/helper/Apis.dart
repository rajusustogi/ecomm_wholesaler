

const BASEURL= "http://ec2-15-207-22-80.ap-south-1.compute.amazonaws.com:3000";
const String MYPROFILE =BASEURL+
    "/my-wholesaler-profile"; // (get api to view my profile) (headers mein token)
const String UPDATEPROFILE =BASEURL+
    "/my-wholesaler-profile"; //(put api) (token) (body: {name, email, mobile_no, password, aadhaar_no, driver_license, address, pincode})
const String LOGINEMPLOYEE =BASEURL+
    "/login-wholesaler"; //(post requestfor login)(body: {emailOrPhone, password})
const String SETPASS =BASEURL+
    "/set-password"; // (put request)(body: {mobile_no, password})
// const String ORDERS =BASEURL+
//     "/delivery-order"; //  (get request to view assigned delivery orders)(headers mein token )
const String CONFIRMDELIVERY=BASEURL+"/deliver-order" ;//(put api) (token) (body: {code, order_id})



//WHOLESALERS
// "/login-wholesaler" (post api) (body: { emailOrPhone, password})
// "/my-wholesaler-profile" (get api) (token)
// "/my-wholesaler-profile" (put api) (token) (body: {name, email, mobile_no, alternate_no, password, address, landmark, state, pincode, latitude, longitude})
// "/my-wholesaler-profile" (delete api) (token)



//WHOLESALER-PRODUCT
// const String ORDERS =BASEURL+"/wholesaler-product/(+id)" ;//(get api) (token)
const String PRODUCTS =BASEURL+"/products-by-wholesaler/";// (get api) (token)
const String UPADTEPRODUCTS =BASEURL+"/wholesalers-products/";// (post api) (token) (body: {product_id, wholesaler_id, mrp, [one of off_percentage, off_amount, deal_price], description})
// const String ORDERS =BASEURL+"/wholesalers-products/(+id)" ;//(put api) (body: {mrp, description, [one of off_percentage, off_amount, deal_price]})
// const String ORDERS =BASEURL+"/wholesalers-products/(+id)" ;//(delete api)
const SEARCH = BASEURL +"/all-products?query=";
const String ADDPRODUCTS =BASEURL+"/wholesalers-products";// (post api) (token) (body: {product_id, wholesaler_id, mrp, [one of off_percentage, off_amount, deal_price], description})

// const String ADDPRODUCTS =BASEURL+"/add-product";///title: string;manufacturer: string;mrp: number;pack_size: 
//string;category_id: number;deal_price?: number;composition?: string;

//PICKUP
// const String ORDERS =BASEURL+"/upcoming-pickups";// (get api => view all products coming from wholesalers) (employee token)
const String ORDERS =BASEURL+"/pickup-products";// (get api => view logged in wholesaler's pickups) (wholesaler token)
// const String ORDERS =BASEURL+"/employee-pickups" ;//(get api => view all pickups of a packager) (Employee token)
const String UPDATEORDER =BASEURL+"/pickup-products/" ;//(put api) (either employee or wholesaler token) (body: {employee_id,
// wholesaler_product_id, payment_status(pending, success, failure), order_status(pending, packed, on the way, delivered, cancelled, rejected, incomplete) ,
// availability(pending, complete, partial, out of stock), available_quantity, pickup_date})

const String INVOICE =BASEURL +'/invoice';
const String ACCEPTEDORDERS = BASEURL +"/accepted-pickups";
const String  CATEGORY =BASEURL +'/productCategories';
const String  TRENDING =BASEURL +'/wholesaler-trends/';

const String UPDATETRENDING = BASEURL+ "/wholesalers-products";