FROM python:3.13.5-alpine3.22

# Define variáveis de ambiente para boas práticas com Python em Docker
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

# Define o diretório de trabalho dentro do contêiner
WORKDIR /app

# Copia o arquivo de dependências primeiro para aproveitar o cache de camadas do Docker.
# Esta camada só será reconstruída se o requirements.txt for alterado.
COPY requirements.txt .

# Instala as dependências
# A flag --no-cache-dir reduz o tamanho final da imagem
RUN pip install --no-cache-dir -r requirements.txt

# Copia o restante do código da aplicação
COPY . .

# Expõe a porta em que a aplicação será executada
EXPOSE 8000

# Comando para iniciar a aplicação quando o contêiner for executado
# Usamos 0.0.0.0 para que a aplicação seja acessível de fora do contêiner.
CMD ["uvicorn", "app:app", "--host", "0.0.0.0", "--port", "8000", "--reload"]
