const { default: mongoose } = require("mongoose");
const orderModel = require("../models/order_model");

const orderController = {
    createOrder: async function (req, res) {
        try {
            const { items, seller, buyer, } = req.body;
            console.log(items);
            console.log(" details :  " + buyer);
            const foundOrder = await orderModel.findOne({ buyer: buyer });
            // console.log(foundCart);
            if (foundOrder == null) {
                console.log(foundOrder);
                const creatingOrder = new orderModel({ seller: seller, buyer: buyer, items: items });
                // creatingOrder.items.push({  productid:product ,quantity:quantity
                // });
                await creatingOrder.save();
                return res.json({ success: true, message: "Order Successfully placed", data: creatingOrder });
            }
            //  await orderModel.findOneAndUpdate(//first pull then push the item in db
            //     {buyer:buyer,"items.product":product}, //match user and product 
            //     {$pull:{items:{product:product,}} }, //dollar pull is array function ->pull value from array means delete values from array using function pull
            //     );
            //if cart exists
            // items.forEach(element => {
            // console.log(element.orderedProduct.productid);
            // console.log(element.totalquantity);
            // });
            items[0].orderedProduct.forEach(element => {
                console.log(element);
            });
            const updatedOrder = await orderModel.findOneAndUpdate(
                { buyer: buyer }, //match condition
                { $push: { items: items } }, // make a changes                //dollar push ->push value in  array function pull
                { new: true } // new version of doc
            ).populate("items.orderedProduct.productid");
            // const updatedOrder =  await orderModel.findOneAndUpdate(
            //     {buyer:buyer}, //match condition
            //     {$push:{items:{productid:product,quantity:quantity}} }, // make a changes                //dollar push ->push value in  array function pull
            //     {new: true} // new version of doc
            //     ).populate("items.product");

            return res.json({ success: true, message: "Order Successfully placed", data: updatedOrder });

        } catch (ex) {
            return res.json({ success: false, message: `Order can't Placed :  ${ex}` });

        }
    },

    fetchOrders: async function (req, res) {

        try {
            const buyerid = req.params.buyerId;
            console.log("orders ");
            console.log(buyerid);

            const foundOrders = await orderModel.find(
                { buyer: buyerid },
            ).populate("items.orderedProduct.productid");
            // .populate('items.orderedProduct.buyer');
            // .populate("items.product").populate("seller");
            console.log(foundOrders);
            console.log("we");

            if (!foundOrders) {
                // console.log(foundBid);
                return res.json({ success: false, data: [], message: "There is no orders to display" });
            } else
                return res.json({ success: true, message: "order found successfully", data: foundOrders });
        } catch (ex) {
            return res.json({ success: false, message: ex.message });
        }
    },

    fetchordersForSeller: async function (req, res) {
        try {
            const sellerId = req.params.sellerId;

            const foundbids = await orderModel.find({
                // "items.orderedProduct.seller": sellerId
            },
                // {totalprice:0,totalquantity:0}
            ).populate('items.orderedProduct.productid').populate('items.orderedProduct.buyer');

            console.log(foundbids);

            if (!foundbids) {


                return res.json({ success: false, data: [], message: "There is no item in your bid" });
            } else {


                const filteredBids = foundbids.map(order => {
                    const filteredItems = order.items.map(item => {
                        const filteredOrderedProducts = item.orderedProduct.filter(product => {
                            return product.seller._id == sellerId;
                        });
                        return {
                            ...item._doc,
                            orderedProduct: filteredOrderedProducts
                        };
                    }).filter(item => item.orderedProduct.length > 0);
                    return {
                        ...order._doc,
                        items: filteredItems
                    };
                }).filter(order => order.items.length > 0);


                return res.json({ success: true, message: "bid found", data: filteredBids });

            }
        } catch (ex) {
            return res.json({ success: false, message: `"bid not found ${ex}"` });

        }
    },

    updateOrderStatus: async function (req, res) {
        try {
            const { status, orderId, buyerId } = req.body;
            console.log("buyerid " + buyerId + " orderId: " + orderId + " status: " + status);

            const order = await orderModel.findOneAndUpdate(
                {
                    buyer: buyerId,
                    'items._id': orderId
                },
                {
                    $set: {
                        'items.$.status': status
                    }
                },
                { new: true }
            );

            console.log(order);
            if (order == null) {
                return res.json({ success: false, message: "order not found." });

            }
            return res.json({ success: true, message: "order found and updated status.", data: status });


        } catch (ex) {
            return res.json({ success: false, message: `"bid not found ${ex}"` });

        }
    }


};





module.exports = orderController;



