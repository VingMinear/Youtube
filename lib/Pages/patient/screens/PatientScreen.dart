import 'package:flutter/material.dart';

class PatientScreen extends StatelessWidget {
  const PatientScreen({super.key});

  @override
  Widget build(BuildContext context) {
    debugPrint('My DebugPrint : ');
    return Scaffold(body: method1(context));
  }

  Widget method1(BuildContext context) {
    return NestedScrollView(
      headerSliverBuilder: (context, innerBoxScrolled) => [
        SliverAppBar(
          centerTitle: true,
          floating: true,
          pinned: true,
          expandedHeight: 250,
          flexibleSpace: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              return FlexibleSpaceBar(
                centerTitle: false,
                background: Image.network(
                  "https://images.unsplash.com/photo-1542601098-3adb3baeb1ec?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=5bb9a9747954cdd6eabe54e3688a407e&auto=format&fit=crop&w=500&q=60",
                  fit: BoxFit.cover,
                ),
              );
            },
          ),
        ),
      ],
      body: RefreshIndicator(
        onRefresh: () async {
          await Future.delayed(
            const Duration(milliseconds: 800),
            () {},
          );
        },
        child: ListView.builder(
          itemBuilder: (context, index) {
            return Container(
              height: 50,
              color: Colors.purple[100 * (index % 9 + 1)],
            );
          },
          itemCount: 5,
        ),
      ),
    );
  }

  Widget method2(BuildContext context) {
    return SafeArea(
        child: NestedScrollView(headerSliverBuilder:
            (BuildContext context, bool innerBoxIsScrolled) {
      return <Widget>[
        SliverOverlapAbsorber(
          handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
          sliver: SliverAppBar(
            expandedHeight: 200.0,
            floating: false,
            pinned: true,
            flexibleSpace: LayoutBuilder(
                builder: (BuildContext context, BoxConstraints constraints) {
              var top = constraints.biggest.height;
              return FlexibleSpaceBar(
                title: AnimatedOpacity(
                  duration: Duration(milliseconds: 10),
                  opacity: top == 56.0 ? 1.0 : 0.0,
                  child: Text("Collapsing Toolbar",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold)),
                ),
                background: Image.network(
                  "https://images.unsplash.com/photo-1542601098-3adb3baeb1ec?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=5bb9a9747954cdd6eabe54e3688a407e&auto=format&fit=crop&w=500&q=60",
                  fit: BoxFit.cover,
                ),
              );
            }),
          ),
        )
      ];
    }, body: Builder(
      builder: (BuildContext context) {
        return CustomScrollView(
          key: PageStorageKey<String>(""),
          slivers: <Widget>[
            SliverOverlapInjector(
              // This is the flip side of the SliverOverlapAbsorber
              // above.
              handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
            ),
            SliverPadding(
              padding: const EdgeInsets.all(8.0),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                    return Container(
                      color: Colors.green,
                      width: double.infinity,
                      height: 200,
                    );
                  },
                  childCount: 1,
                ),
              ),
            ),
          ],
        );
      },
    )));
  }
}
