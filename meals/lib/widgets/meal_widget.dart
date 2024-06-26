import 'package:flutter/material.dart';
import 'package:meals/models/meal_modal.dart';
import 'package:meals/screens/meal_details.dart';
import 'package:transparent_image/transparent_image.dart';

class MealWidget extends StatelessWidget {
  const MealWidget({
    // required this.toggleFavourite,
    required this.meal,
    super.key,
  });
  final Meal meal;

  // final void Function(Meal meal) toggleFavourite;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        clipBehavior: Clip.hardEdge,
        borderOnForeground: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => MealDetails(
                  meal: meal,
                  // toggleFavourite:( Meal meal) {
                  //   toggleFavourite(meal);
                  // },
                ),
              ),
            );
          },
          splashColor: Theme.of(context).colorScheme.onPrimary,
          borderRadius: BorderRadius.circular(12),
          child: Stack(
            // alignment: Alignment.bottomCenter,
            clipBehavior: Clip.hardEdge,
            fit: StackFit.loose,
            children: [
              Hero(
                tag: meal.id,
                child: FadeInImage(
                  fit: BoxFit.cover,
                  height: 200,
                  width: double.infinity,
                  placeholder: MemoryImage(kTransparentImage),
                  image: NetworkImage(meal.imageUrl),
                ),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(1),
                    gradient: LinearGradient(
                      colors: [
                        Theme.of(context)
                            .colorScheme
                            .primaryContainer
                            .withOpacity(0.1),
                        Theme.of(context)
                            .colorScheme
                            .primaryContainer
                            .withOpacity(0.5),
                        Theme.of(context).colorScheme.primaryContainer,
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                    color: Theme.of(context).colorScheme.primaryContainer,
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 15,
                        spreadRadius: 10,
                        blurStyle: BlurStyle.inner,
                        color: Theme.of(context)
                            .colorScheme
                            .primaryContainer
                            .withOpacity(0.3),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Text(
                        meal.title,
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: Theme.of(context).textTheme.titleLarge!.copyWith(
                            color: Theme.of(context).colorScheme.primary),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 12.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            trailingWidget(
                                content: "  ${meal.duration}  min",
                                icon: Icons.alarm,
                                context: context),
                            trailingWidget(
                                content: "  ${meal.complexity.name} ",
                                icon: Icons.work_history_sharp,
                                context: context),
                            trailingWidget(
                                content: "  ${meal.affordability.name} ",
                                icon: Icons.monetization_on,
                                context: context),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget trailingWidget({context, String? content, IconData? icon}) {
    return Padding(
      padding: const EdgeInsets.only(left: 12.0),
      child: Row(
        children: [
          Icon(
            icon,
            color: Colors.white60,
            size: 19,
          ),
          Text(
            content!,
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  color: Colors.white70,
                ),
          ),
        ],
      ),
    );
  }
}
