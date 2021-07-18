import 'package:flutter/material.dart';
import 'data/onlineUsers.dart';
import 'data/friendsMessages.dart';
void main() {
	runApp(MyApp());
}

class MyApp extends StatelessWidget {
	@override
	Widget build(BuildContext context) {
		return MaterialApp(
			home: MyHomeScreen(),
		);
	}
}

class MyHomeScreen extends StatelessWidget {
	const MyHomeScreen({Key? key}) : super(key: key);

	@override
	Widget build(BuildContext context) {
		return Scaffold(
			backgroundColor: Colors.white,
			/* Messanger AppBar */
			appBar: AppBar(
				backgroundColor: Colors.white,
				elevation: 0,
				title: Row(
					mainAxisAlignment: MainAxisAlignment.spaceBetween,
					children: [
						CircleAvatar(
							radius: 15,
							backgroundImage: NetworkImage('https://d1aettbyeyfilo.cloudfront.net/dataskills/unsplash_1602675288.jpg'),
						),
						Text(
							'Chats',
							textAlign: TextAlign.center,
							style: TextStyle(
								color: Colors.black,
								fontSize: 22,
								fontWeight: FontWeight.bold,
							),
						),
						IconButton(
							icon: const Icon(Icons.edit_outlined),
							splashColor: Colors.transparent,
							hoverColor: Colors.transparent,
							highlightColor: Colors.transparent,
							color: Colors.black54,
							onPressed: () => {},
						),
					]
				)
			),

			body: ListView(
				padding: EdgeInsets.symmetric(horizontal: 16),
				children: <Widget>[
					/* Online Friends */
					Row(
						children: <Widget>[
							Expanded(
								child: Container(
									height: 100,
									child: ListView.builder(
										scrollDirection: Axis.horizontal,
										itemCount: onlineUsers.length,
										itemBuilder: (context, index) {
											return UserCard(
												topUserBar: true,
												name: onlineUsers[index]['name'],
												image: onlineUsers[index]['image'],
												preview: '',
												isOnline: true,
												msgDate: ''
											);
										}
									),
								),
							),
						],
					),
					/* search */
					SearchArea(),
					/* Messages List */
					Container(
						child: SingleChildScrollView(
							child: Column(
								children: <Widget> [
									ListView.builder(
										physics: NeverScrollableScrollPhysics(),
										shrinkWrap: true,
										itemCount: friendsMessages.length,
										itemBuilder: (context, index) {
											return UserCard(
												topUserBar: false,
												name: friendsMessages[index]['name'],
												image: friendsMessages[index]['image'],
												preview: friendsMessages[index]['lastMessage'],
												isOnline: friendsMessages[index]['isOnline'],
												msgDate: friendsMessages[index]['msgDate']
											);
										}
									),
								],
							),
						),
					),
				],
			)
		);
	}
}

class UserAvatar extends StatelessWidget {
	final String image;
	final bool isOnline;
	final double paddingRight;
	UserAvatar({
		required this.image,
		required this.isOnline,
		required this.paddingRight
	});
	@override
	Widget build(BuildContext context) {
		return Padding(
			padding: EdgeInsets.only(right: paddingRight),
			child: Stack(
				children: [
					CircleAvatar(
						radius: 30,
						backgroundImage: NetworkImage(image),
					),
					isOnline ?
						Positioned(
							top: 45,
							right: 3,
							child: CircleAvatar(
								radius: 6,
								backgroundColor: Colors.green[500]
							),
						)
					:
						Container()
				],
			),
		);
	}
}

class CardText extends StatelessWidget {
	final bool isColumn;
	final String name;
	final String preview;
	final String msgDate;
	const CardText({
		required this.isColumn,
		required this.name,
		required this.preview,
		required this.msgDate
	});

	@override
	Widget build(BuildContext context) {
		return isColumn ? 
			Column(
				crossAxisAlignment: CrossAxisAlignment.start,
				children: [
					Text(name, 
						style: TextStyle(
							color: Colors.black,
							fontSize: 16,
							fontWeight: FontWeight.bold,
						),
					),
					Text('$preview ${msgDate.length > 0 ? ". $msgDate" : ''}'),
				],
			)
		:
			Padding(
				padding: EdgeInsets.only(top: 5),
				child: Text(
					name,
					textAlign: TextAlign.center,
					softWrap: true,
					maxLines: 2,
					overflow: TextOverflow.ellipsis,
				)
			);
	}
}

class UserCard extends StatelessWidget {
	final bool topUserBar;
	final String name;
	final String image;
	final String preview;
	final bool isOnline;
	final String msgDate;
	const UserCard({
		required this.topUserBar,
		required this.name,
		required this.image,
		required this.preview,
		required this.isOnline,
		required this.msgDate
	});

	@override
	Widget build(BuildContext context) {
		return topUserBar ?
			Container(
				width: 60,
				margin: EdgeInsets.only(right: 15),
				child: Column(
					children: [
						UserAvatar(image: image, isOnline: isOnline, paddingRight: 0),
						CardText(isColumn: false, name: name, preview: preview, msgDate: msgDate)
					],
				),
			)
		:
			Container(
				margin: EdgeInsets.only(bottom: 15),
				child: Row(
					children: [
						UserAvatar(image: image, isOnline: isOnline, paddingRight: 15),
						CardText(isColumn: true, name: name, preview: preview, msgDate: msgDate)
					],
				),
			);
	}
}

class SearchArea extends StatefulWidget {
	const SearchArea({ Key? key }) : super(key: key);

	@override
	_SearchAreaState createState() => _SearchAreaState();
}
class _SearchAreaState extends State<SearchArea> {
	@override
	Widget build(BuildContext context) {
		return Container(              
			height: 45,
			margin: EdgeInsets.symmetric(vertical: 20),
			child: TextField(
				keyboardType: TextInputType.text,
				decoration: InputDecoration(
					hintText: 'Search',
					hintStyle: TextStyle(fontSize: 14),
					border: OutlineInputBorder(
						borderRadius: BorderRadius.circular(100),
						borderSide: BorderSide(
							width: 0, 
							style: BorderStyle.none,
						),
					),
					filled: true,
					contentPadding: EdgeInsets.all(16),
					fillColor: Colors.grey[200],
					prefixIcon: Icon(Icons.search),
				),
			),
		);
	}
}