event:
  push_event:
    branch: ${branch_name} # dev, master
  tag_event:
    tag: ${branch_name} # tag_name

param:
  branch_name: master
  git_site: gitee.com

workflow:
  name: jianmu-front-build-image
  ref: jianmu_front_build_image
  description: 建木创建前端镜像
  Start:
    type: start
    targets:
      - Git_Clone_Ui
  Git_Clone_Ui:
    type: git_clonev1.0
    sources:
      - Start
    targets:
      - Build
    param:
      workspace: jianmu-ui
      commit_branch: ${branch_name}
      remote_url: https://gitee.com/jianmu_dev/jianmu-ui.git
      netrc_machine: ${git_site}
      netrc_username: ((gitee.user))
      netrc_password: ((gitee.pass))
  Build:
    type: node14.2
    sources:
      - Git_Clone_Ui
    targets:
      - Git_Clone_Image
    param:
      workspace: jianmu-ui
  Git_Clone_Image:
    type: git_clonev1.0
    sources:
      - Build
    targets:
      - Create
    param:
      workspace: jianmu-ui-image
      commit_branch: ${branch_name}
      remote_url: https://gitee.com/jianmu_dev/jianmu-ui-image.git
      netrc_machine: ${git_site}
      netrc_username: ((gitee.user))
      netrc_password: ((gitee.pass))  
  Create:
    type: create_web_image0.6
    sources:
      - Git_Clone_Image
    targets:
      - End
    param:
      workspace: jianmu-ui-image
      docker_username: ((dockerhub.Username))
      docker_password: ((dockerhub.Password))
      image_name: jianmu-web
      image_tag: "1.2"
  End:
    type: end
    sources:
      - Create
