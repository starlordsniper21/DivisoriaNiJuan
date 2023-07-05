import 'package:divisorianijuanmain/consts/consts.dart';
import 'package:divisorianijuanmain/consts/list.dart';
import 'package:divisorianijuanmain/controllers/product_controller.dart';
import 'package:divisorianijuanmain/views/splashscreen/catergoryscreen/category_details.dart';
import 'package:divisorianijuanmain/views/splashscreen/loginScreenBg.dart';
import 'package:get/get.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(ProductController());

    return bgWidget(
      child: Scaffold(
        appBar: AppBar(
          title: categories.text.fontFamily(bold).white.make(),
        ),
        body: Container(
          padding: const EdgeInsets.all(12),
          child: GridView.builder(
            shrinkWrap: true,
            itemCount: 9,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisSpacing: 8,
                crossAxisSpacing: 8,
                mainAxisExtent: 200),
            itemBuilder: (context, index) {
              return Column(
                children: [
                  Image.asset(
                    categoryImages[index],
                    width: 200,
                    height: 120,
                    fit: BoxFit.cover,
                  ),
                  10.heightBox,
                  categoriesList[index].text.color(darkFontGrey).make(),
                ],
              )
                  .box
                  .white
                  .rounded
                  .clip(Clip.antiAlias)
                  .outerShadowSm
                  .make()
                  .onTap(
                () {
                  controller.getSubCategories(categoriesList[index]);
                  Get.to(
                    () => CategoryDetails(title: categoriesList[index]),
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
