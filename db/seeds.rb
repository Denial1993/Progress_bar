# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


#categories是一個array,這個array裡面有兩個hash,所以代表有兩個category...[顯示主分類與副分類]章節有講到(05:50)

user = User.create(name: "server",email: "server@gmail.com",password: "123456")

categories = [
  { #主類別
    "name": "安全帽",
    #副類別
    "subcategories": ["全罩","可掀式全罩","半罩"]
  },
  {
    "name": "防摔衣",
    "subcategories":["夏季網眼防摔衣","連身皮衣","兩截式皮衣","龜甲"]
    },
  {
    "name": "防摔褲",
    "subcategories":["休閒防摔褲","防摔褲","皮褲"]
    },
  {
    "name": "車靴",
    "subcategories":["休閒車靴","高筒車靴","低筒車靴"]
    },
  {
    "name": "防摔手套",
    "subcategories":["防水手套","防摔網布手套","防摔皮革手套"]
    },
  {
    "name": "紅牌重機",
    "subcategories":["CBR650R","CBR600RR","CBR1000RR","YZF-R6","YZF-R1","Panigale V4"]
    }
]

categories.each do |c_data|
  #這裡我每得到一個c_data,我就建立一個category
  #這邊 c_data[:name] 是個 hash.
  category = Category.create(name: c_data[:name])
  c_data[:subcategories].each do |s_data_name|
    subcategory = Subcategory.create(name: s_data_name,category: category )
  end
end


subcategory = Subcategory.first
#PRODUCTS_COUNT = 100 <=這些要放在下面,ruby順序讀取的問題，從上到下,所以這個要放下面拉! 
PRODUCTS_COUNT = 100

(1..PRODUCTS_COUNT).each do |index|
  product = 
  {
    name: "Ducati Panigale V4 #{index}",
    description: "this is a sportbike.",
    image_url: "https://images.pexels.com/photos/1309668/pexels-photo-1309668.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940",
    #記得如果要 [subcategory: subcategory] 的話, 你的 belongs_to 必須要寫.
    subcategory: subcategory
  }

  Product.create(product)
end