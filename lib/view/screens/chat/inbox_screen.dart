import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sixvalley_vendor_app/localization/language_constrants.dart';
import 'package:sixvalley_vendor_app/provider/chat_provider.dart';
import 'package:sixvalley_vendor_app/utill/color_resources.dart';
import 'package:sixvalley_vendor_app/utill/dimensions.dart';
import 'package:sixvalley_vendor_app/view/base/custom_app_bar.dart';
import 'package:sixvalley_vendor_app/view/base/custom_loader.dart';
import 'package:sixvalley_vendor_app/view/base/no_data_screen.dart';
import 'package:sixvalley_vendor_app/view/base/paginated_list_view.dart';
import 'package:sixvalley_vendor_app/view/screens/chat/widget/chat_card_widget.dart';
import 'package:sixvalley_vendor_app/view/screens/chat/widget/chat_header.dart';

class InboxScreen extends StatefulWidget {
  final bool isBackButtonExist;
  const InboxScreen({
    Key? key,
    this.isBackButtonExist = true,
  }) : super(key: key);

  @override
  State<InboxScreen> createState() => _InboxScreenState();
}

class _InboxScreenState extends State<InboxScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    Provider.of<ChatProvider>(context, listen: false).getChatList(context, 1);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorResources.getIconBg(context),
      appBar: CustomAppBar(title: getTranslated('inbox', context)),
      body: Consumer<ChatProvider>(
        builder: (context, chatProvider, child) {
          return Column(children: [
            Container(
                padding: const EdgeInsets.symmetric(
                    vertical: Dimensions.paddingSizeExtraSmall),
                child: const ChatHeader()),
            chatProvider.chatModel != null
                ? (chatProvider.chatModel!.chat != null &&
                        chatProvider.chatModel!.chat!.isNotEmpty)
                    ? Expanded(
                        child: RefreshIndicator(
                          onRefresh: () async {
                            chatProvider.getChatList(context, 1);
                          },
                          child: Scrollbar(
                              child: SingleChildScrollView(
                                  controller: _scrollController,
                                  child: FutureBuilder(
                                    future:
                                        chatProvider.getChatList(context, 1),
                                    builder: ((context, snapshot) {
                                      return Center(
                                          child: SizedBox(
                                              width: 1170,
                                              child: Padding(
                                                padding: const EdgeInsets
                                                    .symmetric(
                                                    horizontal: Dimensions
                                                        .paddingSizeDefault),
                                                child: PaginatedListView(
                                                  reverse: false,
                                                  scrollController:
                                                      _scrollController,
                                                  onPaginate: (int? offset) =>
                                                      chatProvider.getChatList(
                                                          context, offset!,
                                                          reload: false),
                                                  totalSize: chatProvider
                                                      .chatModel!.totalSize,
                                                  offset: int.parse(chatProvider
                                                      .chatModel!.offset!),
                                                  enabledPagination:
                                                      chatProvider.chatModel ==
                                                          null,
                                                  itemView: ListView.builder(
                                                    itemCount: chatProvider
                                                        .chatModel!
                                                        .chat!
                                                        .length,
                                                    padding: EdgeInsets.zero,
                                                    physics:
                                                        const NeverScrollableScrollPhysics(),
                                                    shrinkWrap: true,
                                                    itemBuilder:
                                                        (context, index) {
                                                      return ChatCardWidget(
                                                          chat: chatProvider
                                                              .chatModel!
                                                              .chat![index]);
                                                    },
                                                  ),
                                                ),
                                              )));
                                    }),
                                  ))),
                        ),
                      )
                    : const Expanded(child: NoDataScreen())
                : Expanded(
                    child: CustomLoader(
                        height: MediaQuery.of(context).size.height - 500)),
          ]);
        },
      ),
    );
  }
}
