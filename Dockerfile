FROM nginx:1.21.0
COPY nginx-http.conf /etc/nginx/conf.d/defalt.conf 
COPY dist /home/dist
