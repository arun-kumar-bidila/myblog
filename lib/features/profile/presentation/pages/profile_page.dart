import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:myblog/common/widgets/loader.dart';
import 'package:myblog/common/cubits/app_user/app_user_cubit.dart';
import 'package:myblog/common/theme/app_pallete.dart';
import 'package:myblog/core/utils/show_snackbar.dart';
import 'package:myblog/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:myblog/features/blog/presentation/widgets/blog_card.dart';
import 'package:myblog/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:myblog/features/profile/presentation/widgets/edit_password_button.dart';
import 'package:myblog/features/profile/presentation/widgets/logout_button.dart';
import 'package:myblog/features/profile/presentation/widgets/profile_feature.dart';
import 'package:myblog/features/profile/presentation/widgets/theme_switch.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  void initState() {
    super.initState();
    context.read<ProfileBloc>().add(ProfileFetchUserBlogs());
  }

  String opted = "Info";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new_rounded),
          onPressed: () => context.go("/blog"),
        ),
        title: Text(
          "My Profile",
          style: Theme.of(context).textTheme.titleLarge,
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: BlocBuilder<AppUserCubit, AppUserState>(
            builder: (context, state) {
              if (state is! AppUserLoggedIn) {
                return Loader();
              }
              final user = state.user;
              return BlocConsumer<AuthBloc, AuthState>(
                listener: (context, state) {
                  if (state is AuthLogOutFailure) {
                    showSnackBar(context, "LogOut Failure");
                  }
                  if (state is AuthLogOutSuccess) {
                    showSnackBar(context, state.message);
                  }
                },
                buildWhen: (previous, current) =>
                    current is AuthLogOutLoading ||
                    current is AuthLogOutFailure,
                builder: (context, state) {
                  if (state is AuthLogOutLoading) {
                    return Loader();
                  }
                  return SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(30),
                              decoration: BoxDecoration(
                                color: AppPallete.secondaryColor,
                                shape: BoxShape.circle,
                              ),
                              child: Text(
                                user.name[0].toUpperCase(),
                                style: TextStyle(
                                  color: AppPallete.whiteColor,
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            SizedBox(width: 20),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  user.name,
                                  style: Theme.of(context).textTheme.titleLarge,
                                ),
                                SizedBox(height: 10),
                                Text(
                                  user.email,
                                  style: Theme.of(
                                    context,
                                  ).textTheme.titleMedium,
                                ),
                              ],
                            ),
                          ],
                        ),

                        SizedBox(height: 30),
                        Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(160),
                            color: AppPallete.blackColor,
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      opted = "Info";
                                    });
                                  },
                                  child: Container(
                                    padding: EdgeInsets.symmetric(vertical: 8),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(16),
                                      color: opted == "Info"
                                          ? AppPallete.secondaryColor
                                          : AppPallete.transparentColor,
                                    ),
                                    child: Center(
                                      child: Text(
                                        "Info",
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleMedium!
                                            .copyWith(
                                              color: AppPallete.whiteColor,
                                            ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),

                              Expanded(
                                child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      opted = "Blogs";
                                    });
                                  },
                                  child: Container(
                                    padding: EdgeInsets.symmetric(vertical: 8),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(16),
                                      color: opted == "Blogs"
                                          ? AppPallete.secondaryColor
                                          : AppPallete.transparentColor,
                                    ),
                                    child: Center(
                                      child: Text(
                                        "Blogs",
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleMedium!
                                            .copyWith(
                                              color: AppPallete.whiteColor,
                                            ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 30),

                        if (opted == "Info") ...[
                          ProfileFeature(
                            icon: Icons.person_pin,
                            label: "Name",
                            value: user.name,
                          ),
                          ProfileFeature(
                            icon: Icons.email_rounded,
                            label: "Mail",
                            value: user.email,
                          ),
                          EditInfoPasswordButton(
                            icon: Icons.edit_square,
                            label: "Edit Personal Info",
                            onTap: () {
                              context.push("/edit-info");
                            },
                          ),
                          EditInfoPasswordButton(
                            icon: Icons.visibility_off_rounded,
                            label: "Change Password",
                            onTap: () {
                              context.push("/change-password");
                            },
                          ),

                          ThemeSwitch(),
                          SizedBox(height: 50),
                          LogoutButton(),
                        ],
                        if (opted == "Blogs") ...[
                          BlocConsumer<ProfileBloc, ProfileState>(
                            listener: (context, state) {
                              if (state is ProfileFetchUserBlogsFailure) {
                                showSnackBar(context, state.message);
                              }
                            },
                            builder: (context, state) {
                              if (state is ProfileFetchUserBlogsLoading) {
                                return Loader();
                              }
                              if (state is ProfileFetchUserBlogsSuccess) {
                                final blogs = state.blogs;

                                if (blogs.isEmpty) {
                                  return Padding(
                                    padding: const EdgeInsets.only(top: 40.0),
                                    child: Center(
                                      child: Text(
                                        "No blogs yet",
                                        style: TextStyle(
                                          color: AppPallete.secondaryColor,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  );
                                }

                                return ListView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: blogs.length,
                                  itemBuilder: (context, index) {
                                    final blog = blogs[index];
                                    return BlogCard(blog: blog);
                                  },
                                );
                              }

                              return Loader();
                            },
                          ),
                        ],
                      ],
                    ),
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
